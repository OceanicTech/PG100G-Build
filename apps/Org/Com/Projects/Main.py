__package__ = "apps.Org.Com.Projects"
from ExtraSources import plugins_loader

class Main:
    def __init__(self):
        self.plugins = []

    def load_plugins(self):
        [plugins_loader.load_plugin('hello_plugins')]
    