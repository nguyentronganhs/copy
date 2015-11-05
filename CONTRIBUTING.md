# How to contribute

Redhopper is free software and welcomes any feedback or contribution so do not hesitate to contact us.

Feel free to improve this contribution guide.

## Provide feedback

1. You can email us at **redhopper (at) infopiiaf.fr** (French and English spoken);
2. Open an issue on [Framagit](https://git.framasoft.org/infopiiaf/redhopper) (which uses [Gitlab CE](https://about.gitlab.com/features/#community)).

And let's talk about it!

## Provide code

There are two ways to provide code for Redhopper, the first one being the preferred one :
1. Fork the project on [Framagit](https://git.framasoft.org/infopiiaf/redhopper) and propose a [merge request](https://git.framasoft.org/help/gitlab-basics/add-merge-request.md)
2. Send a git patch to **redhopper (at) infopiiaf.fr** (French and English spoken)

In either way, please try to stick to following rules.

### Prerequisites

We recommand you develop and test the plugin within a test instance of Redmine.

To be able to work on the tool (`RAILS_ENV=development`):
  - install Redmine : [how to install Redmine](http://www.redmine.org/projects/redmine/wiki/RedmineInstall)
  - install Redhopper : [how to install the plugin](https://git.framasoft.org/infopiiaf/redhopper#how-does-it-work)
  - in order to see if everything is ok
    - start redmine: `bundle exec rails server`
    - launch the tests: `bundle exec rake redmine:plugins:test NAME=redhopper`

Now you can work on improving Redhopper.

### Provide tests

Your patch will have more chance to be included within the tool if your improve is well tested. If you find yourself lost do not hesitate to tell us.

In order to only perform the tests of the plugin, go to the redmine path and hit `bundle exec rake redmine:plugins:test NAME=redhopper`

### CSS

#### SASS

Unfortunately Redmine does not use SASS (yet) but we use it to develop Redhopper. If you want to perform modifications on the CSS, you will **have to** modify the SASS file and launch **???**. Then commit both the SASS and CSS files.

#### Conventions

We're (mostly) using CSS conventions inspired by [SMACSS](https://smacss.com/book/categorizing), [BEM](https://en.bem.info/method/definitions/) and [SUIT CSS](http://suitcss.github.io/). It relies on a few principles :

0. Style CSS classes, not HTML elements or IDs;
0. Make a clear distinction between a UI component, its states and subcomponents:
 * `.Component`: capitalized noun;
 * `.Component.is-active`: `is-` prefixed + adjective;
 * `.Component-subcomponent`: `-` suffixed + lowercase noun;
0. An HTML element may be a component and a subcomponent :
 * the _component_ class is for cosmetics;
 * the _subcomponent_ class is for positioning.

For instance, a kanban board might use classes like `KanbanBoard`, `KanbanBoard-column`, `Column`, `Column-kanban`, `Kanban`, `Kanban.is-blocked`…
