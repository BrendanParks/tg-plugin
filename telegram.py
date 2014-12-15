import subprocess

class Telegram:


  def __init__(tg_loc):
    self.tgcli_location = tg_loc
    
  def start(self):
    subprocess.Popen(self.tgcli_location





