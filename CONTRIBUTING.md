# How to contribute

Redhopper is free software and welcomes any feedback or contribution so do not hesitate to contact us.

## Provide feedback

1. You can email us at **redhopper (at) infopiiaf.fr** (French and English spoken);
2. Open an issue on [Framagit](https://git.framasoft.org/infopiiaf/redhopper) (which uses [Gitlab CE](https://about.gitlab.com/features/#community)).

And let's talk about it!

## Provide code

### CSS conventions

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