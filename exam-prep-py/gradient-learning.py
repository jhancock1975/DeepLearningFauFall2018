import numpy as np
import logging


if __name__ == "__main__":
    num_passes = 2
    logger = logging.getLogger(__name__)
    c_handler = logging.StreamHandler()
    c_format = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    logger.addHandler(c_handler)
    logger.setLevel(logging.DEBUG)
    logger.debug("done")