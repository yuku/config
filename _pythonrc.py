try:
    from IPython.frontend.terminal.ipapp import launch_new_instance
    launch_new_instance()
    raise SystemExit
except ImportError:
    pass
