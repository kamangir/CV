import argparse
from CV import *
from abcli import logging
import logging

logger = logging.getLogger(__name__)


parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{version}")
parser.add_argument("task", type=str, help="build")
args = parser.parse_args()

success = False
if args.task == "build":
    success = build()
else:
    logger.error(f"-{NAME}: {args.task}: command not found.")

if not success:
    logger.error(f"-{NAME}: {args.task}: failed.")
