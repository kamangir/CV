import argparse

from . import *
from .build import *


from bolt import logging
import logging

logger = logging.getLogger(__name__)


parser = argparse.ArgumentParser(description="CV-{:.2f}".format(version))
parser.add_argument("task", type=str, help="build")
args = parser.parse_args()

success = False
if args.task == "build":
    success = build()
else:
    logger.error('CV: unknown task "{}".'.format(args.task))

if not success:
    logger.error("CV.{} failed.".format(args.task))
