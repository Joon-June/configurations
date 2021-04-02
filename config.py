import argparse
import functools
import os
import random

import numpy as np
import torch

CONFIG = {}


def set_arguments(args):
    global CONFIG
    # Hyperparameters
    CONFIG["EXP_NAME"] = args.exp_name
    CONFIG["LR"] = args.lr
    CONFIG["LR_DECAY_RATE"] = args.lr_decay_rate
    CONFIG["LR_DECAY_STEP_SIZE"] = args.lr_decay_step_size
    CONFIG["BATCH_SIZE"] = args.batch_size
    CONFIG["NUM_EPOCHS"] = args.num_epochs
    CONFIG["WEIGHT_DECAY"] = args.weight_decay
    CONFIG["DROPOUT"] = args.dropout
    CONFIG["NUM_WORKERS"] = args.num_workers
    CONFIG["PARALLEL"] = args.parallel
    CONFIG["SAVE"] = args.save
    CONFIG["DATE"] = args.date
    CONFIG["SEED"] = args.seed
    CONFIG["GPU"] = list(range(len(args.gpu)))
    CONFIG["VIZ"] = args.viz

    CONFIG["DEVICE"] = torch.device("cuda")
    os.environ["CUDA_VISIBLE_DEVICES"] = functools.reduce(lambda a, b: a + b, args.gpu)

    # Paths
    CONFIG["SOURCE_DIR"] = os.path.abspath(os.path.split(__file__)[0])
    CONFIG["MODEL_DIR"] = os.path.abspath(os.path.join(CONFIG["SOURCE_DIR"], "../models"))
    CONFIG["DATA_DIR"] = os.path.abspath(os.path.join(CONFIG["SOURCE_DIR"], "../data"))
    CONFIG["TB_LOG_DIR"] = os.path.abspath(os.path.join(CONFIG["SOURCE_DIR"], "../runs"))
    CONFIG["VIZ_DIR"] = os.path.join(CONFIG["DATA_DIR"], "viz")
    CONFIG["TRAIN_DIR"] = os.path.join(CONFIG["DATA_DIR"], "train_overlaid")
    CONFIG["TRAIN_IMAGE_DIR"] = os.path.join(CONFIG["DATA_DIR"], "images")
    CONFIG["TRAIN_MASK_DIR"] = os.path.join(CONFIG["DATA_DIR"], "masks")
    CONFIG["VALID_DIR"] = os.path.join(CONFIG["DATA_DIR"], "validation_overlaid")
    CONFIG["TEST_DIR"] = os.path.join(CONFIG["DATA_DIR"], "test")
    CONFIG["MODEL_NAME"] = f"MODEL_NAME_{CONFIG['EXP_NAME']}_" \
                           f"{CONFIG['DATE']}_" \
                           f"LR_{CONFIG['LR']}_" \
                           f"LR_DECAY_RATE_{CONFIG['LR_DECAY_RATE']}_" \
                           f"LR_DECAY_STEP_SIZE_{CONFIG['LR_DECAY_STEP_SIZE']}_" \
                           f"BATCH_SIZE_{CONFIG['BATCH_SIZE']}_" \
                           f"NUM_EPOCHS_{CONFIG['NUM_EPOCHS']}_" \
                           f"WEIGHT_DECAY_{CONFIG['WEIGHT_DECAY']}_" \
                           f"DROPOUT_{CONFIG['DROPOUT']}"

    if CONFIG["SEED"] > 0:
        set_seeds(CONFIG["SEED"])


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--exp_name", type=str, default="EXP0", help="Name of experiment you want to run")
    parser.add_argument("--lr", type=float, default=0.001, help="Learning rate")
    parser.add_argument("--lr_decay_rate", type=float, default=0.5, help="Learning rate decay rate")
    parser.add_argument("--lr_decay_step_size", type=int, default=5, help="Learning rate decay step size")
    parser.add_argument("--batch_size", type=int, default=64, help="Training batch size")
    parser.add_argument("--num_epochs", type=int, default=30, help="Number of epochs")
    parser.add_argument("--weight_decay", type=float, default=0.0, help="L2 regularization term")
    parser.add_argument("--dropout", type=float, default=0.2, help="Dropout rate")
    parser.add_argument("--num_workers", type=int, default=4, help="Number of data loader workers")
    parser.add_argument("--parallel", action="store_true", default=0, help="Data parallelism")
    parser.add_argument("--save", action="store_true", default=0, help="Save a model?")
    parser.add_argument("--date", type=str, default="0000", help="Date of experiment")
    parser.add_argument("--seed", type=int, default=-1, help="Random seed")
    parser.add_argument("--gpu", nargs="+", default="0", help="GPU nubmers you want to use")
    parser.add_argument("--viz", action="store_true", default=0, help="Visualize the results?")

    args = parser.parse_args()
    return args


def set_seeds(seed):
    print(f"Setting seeds with {seed}...")
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)  # if use multi-GPU
    torch.backends.cudnn.deterministic = True
    torch.backends.cudnn.benchmark = False
    np.random.seed(seed)
    random.seed(seed)


