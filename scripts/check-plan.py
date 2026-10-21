import os
import subprocess
import sys

runner = 'npm.cmd' if os.name == 'nt' else 'npm'
result = subprocess.run([runner, 'run', 'test:e2e', '--', *sys.argv[1:]], check=False)
raise SystemExit(result.returncode)
