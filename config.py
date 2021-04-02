import argparse

CONFIG = {}


def set_arguments(args):
    global CONFIG
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
    CONFIG["GPU"] = args.gpu
    CONFIG["VIZ"] = args.viz


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--exp_name", type=str, default="EXP0", help="Name of experiment you want to run")
    parser.add_argument("--lr", type=float, default=0.001, help="Learning rate")
    parser.add_argument("--lr_decay_rate", type=float, default=0.5, help="Learning rate decay rate")
    parser.add_argument("--lr_decay_step_size", type=int, default=5, help="Learning rate decay step size")
    parser.add_argument("--batch_size", type=int, default=64, help="Training batch size")
    parser.add_argument("--num_epochs", type=int, default=30, help="Number of epochs")
    parser.add_argument("--weight_decay", type=float, default=0.001, help="L2 regularization term")
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
