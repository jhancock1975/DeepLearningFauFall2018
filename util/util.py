
import logging


def create_logger(name, level=logging.DEBUG):
    """
    try to cut down on boilerplate code to create logger
    :param name:  logger name
    :param level:  log level, defaults to debbug
    :return: configured logger
    """
    logger = logging.getLogger(name)
    c_handler = logging.StreamHandler()
    c_format = logging.Formatter('%(asctime)s %(name)s - %(levelname)s - %(message)s')
    c_handler.setFormatter(c_format)
    logger.addHandler(c_handler)
    logger.setLevel(level)
    return logger