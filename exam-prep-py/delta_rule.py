import numpy as np
import logging


if __name__ == "__main__":
    logger = logging.getLogger(__name__)
    c_handler = logging.StreamHandler()
    c_format = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    logger.addHandler(c_handler)
    logger.setLevel(logging.DEBUG)
    logger.debug("starting up")
    inputs=[[1.0, 1.0, 0.0],
            [1.0, 1.0, 1.0],
            [1.0, 0.0, -1.0],
            [1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0],
            [1.0, -1.0, -1.0]]
    desired_outputs = [1.0, 1.0, 1.0, 0.0, 0.0, 0.0]
    weights = [1.0, 1.0, 1.0]
    eta = 0.1
    num_passes = 1
    for i in range(num_passes):
        for cur_features, desired in zip(inputs, desired_outputs):
            logger.debug("current features %s", cur_features)
            delta_w = [0.0, 0.0, 0.0]
            logger.debug("desired = %f", desired)
            for j in range(len(delta_w)):
                actual = np.dot(cur_features, weights)
                logger.debug("actual = %f", actual)
                delta_w[j] = eta * (desired - actual) * cur_features[j]
            logger.debug("delta_w = %s", delta_w)
            for j in range(len(weights)):
                weights[j] += delta_w[j]
            logger.debug("weights = %s", weights)
    logger.debug("done")