import os
import subprocess
import json
import tempfile

# =============================================================================


def get_verbose():
    """
    Returns true when in verbose mode
    """
    return int(os.getenv("VERBOSE", "0")) > 0


def get_surelog():
    """
    Searches for the Surelog executable.
    """

    def is_exe(fpath):
        """
        Returns True if a file exists and is executable.
        """
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    # The environmental variable "SURELOG" is set. It should point to the
    # Surelog executable.
    fpath = os.environ.get("SURELOG", None)
    if is_exe(fpath):
        return fpath

    # Look for the 'surelog' binary in the current PATH but only if the PATH
    # variable is available.
    elif "PATH" in os.environ:
        for path in os.environ["PATH"].split(os.pathsep):
            fpath = os.path.join(path, "surelog")
            if is_exe(fpath):
                return fpath

    # Couldn't find Surelog.
    return None


def run(params):
    """
    Runs Surelog with given parameters.
    """

    verbose = get_verbose()

    # Prepare the command
    listener = os.path.join(os.path.dirname(__file__), "v2x_listener.py")
    cmd = [get_surelog()] + params +  ["-pythonlistenerfile", listener]

    if verbose:
        msg = ""
        msg += "command".ljust(9).ljust(80, "=") + "\n"
        msg += str(cmd)
        print(msg)

    # Run the process
    with tempfile.TemporaryDirectory(prefix="surelog_") as tmp:

        odir_opts = ["-odir", tmp]
        p = subprocess.Popen(cmd + odir_opts,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # Get the output
        stdout, stderr = p.communicate()
        stdout = stdout.decode("utf-8")
        stderr = stderr.decode("utf-8")

        retcode = p.wait()

    if verbose:
        msg = ""

        if len(stdout):
            msg += "stdout".ljust(9).ljust(80, "=") + "\n"
            msg += stdout

        if len(stderr):
            msg += "stderr".ljust(9).ljust(80, "=") + "\n"
            msg += stderr

        msg += "exitcode".ljust(9).ljust(80, "=") + "\n"
        msg += "{}\n".format(retcode)

        msg += "=" * 80 + "\n"
        print(msg)

    if retcode != 0:
        emsg = ""
        emsg += "Surelog failed with exit code {}\n".format(retcode)
        emsg += "Command: '{}'\n".format(" ".join(cmd))
        emsg += "Message:\n"
        emsg += "\n".join([" " + l for l in stdout.splitlines()
            if "V2X:" not in l])

        raise subprocess.CalledProcessError(retcode, cmd, emsg)

    # Now parse the output
    json_lines = [l for l in stdout.splitlines() if l.startswith("V2X:")]
    json_lines = [l.replace("V2X:", "") for l in json_lines]

    if len(json_lines) == 0:
        return dict()

    return json.loads("\n".join(json_lines))


def extract_attributes(infiles, defines):
    """
    Extracts attributes from various objects/statements in Verilog file(s)
    using Surelog.

    Returns a dict indexed by module names with the data.
    """

    # Input files
    opts = list(infiles)
    # Defines
    opts += ["+define+" + "+".join(["{}=1".format(d) for d in defines])]

    # Run
    try:
        json_root = run(opts)
    except subprocess.CalledProcessError as ex:
        print(ex.output)
        exit(-1)

    # Return the output
    return json_root
