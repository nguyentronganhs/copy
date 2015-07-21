# Redhopper plugin

Kanban boards for Redmine, inspired by *Jira Agile* (formerly known as *Greenhopper*), but following its own path.

## Wait. But why?

Yep, we are building yet another Kanban plugin for Redmine. The difference this time is the **extensive use of Redmine core concepts** (issues, trackers, workflow, etc.) instead of building everything from scratch.

No need to define columns, your issue statuses are good enough. No need to define allowed transitions, your workflow already does it. Get a useful board in seconds. We believe this is the only way to **achieve fast adoption** for teams already using Redmine like us.

## How does it work?

First, [install the plugin](http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin).

### *Out-of-the-box* behaviour

Inside a project, you now have a new tab called *Kanbans*. This view displays all the issue statuses in columns, sorted according to your settings in Redmine administration. All the visible issues for the current user are listed within the column matching their status.

From now on, the best way to interact with your issues is by right-clicking them. Change its status or assigned person, go to the *Edit issue* view… Using the same contextual menu as the *Issues* view, your **workflow and user rights are preserved**.  
*NB : it is the main reason why drag'n'drop between issue statuses hasn't been implemented yet. It works well enough to focus on other features.*

All the kanbans (card-shaped issues) summarize its issue : id, subject, notes and attachments count, assigned person… Things you like to know in a glance.
