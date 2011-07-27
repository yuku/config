# Mercurial extension to provide the 'hg info' command
#
# Copyright 2008 by Paul Moore <p.f.moore@gmail.com>
# Author(s):
# Paul Moore <p.f.moore@gmail.com>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.

from mercurial.i18n import _
from mercurial.node import short, hex

def info(ui, repo):
    """Print information about the repository"""
    try:
        numrev = repo.changelog.count()
    except AttributeError:              # post Mercurial 1.1
        numrev = len(repo)

    ui.write(_("Repository: %s [hg root]\n") % (repo.root,))
    ui.write(_("Base Hash: %s [hg id -r0]\n") % (hex(repo.changectx(0).node()),))
    ui.write(_('Revisions: %s [hg tip --template "{rev}"]\n') % (numrev,))
    ui.write(_("Files: %s [hg manifest | wc -l]\n") % (len(repo.changectx(numrev-1).manifest()),))
    ui.write(_("Cloned From: %s [hg paths default]\n") % (ui.config('paths','default'),))
    default_push = ui.config('paths','default-push')
    if default_push:
        ui.write(_("Push To: %s [hg paths default-push]\n") % (default_push,))


cmdtable = {
    # "command-name": (function-call, options-list, help-string)
    "info": (info, [], _("hg info"))
}

