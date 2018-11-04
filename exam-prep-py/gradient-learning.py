import numpy as np
import logging


if __name__ == "__main__":
    logger = logging.getLogger(__name__)
    c_handler = logging.StreamHandler()
    c_format = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    logger.addHandler(c_handler)
    logger.setLevel(logging.DEBUG)
    logger.debug("starting up")
    num_passes = 2
    inputs = [[1.0, 1.0, 0.0],
              [1.0, 1.0, 1.0],
              [1.0, 0.0, -1.0],
              [1.0, 0.0, 1.0],
              [1.0, -1.0, 0.0],
              [1.0, -1.0, -1.0]]
    desired_outputs = [1.0, 1.0, 1.0, 0.0, 0.0, 0.0]
    weights = [1.0, 1.0, 1.0]
    eta = 0.1
    for i in range(num_passes):
        sum_delta_w = [0.0, 0.0, 0.0]
        for cur_input, desired in zip(inputs, desired_outputs):
            actual = np.dot(cur_input, weights)
            delta_W = [0.0, 0.0, 0.0]
            for j in range(len(weights)):
                delta_W[j] = eta*(desired - actual)*cur_input[j]
            logger.debug("delta_w = %s", delta_W)
            for j in range(len(weights)):
                sum_delta_w[j] += delta_W[j]
        logger.debug("sum_delta_w %s", sum_delta_w)
        for j in range(len(weights)):
            weights[j] += sum_delta_w[j]
        logger.debug("new values for weights = %s", weights)