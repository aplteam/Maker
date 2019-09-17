# The XML file `publish.config`

## Overview

The XML file `publish.config` is used by two different processes:

1. When loading a project with the user command `]OpenMyAcreProject`.

   This user command is a super set of acre's user command `]acre.OpenProject`.

   The file defines dependencies and the user commands makes sure that they are loaded into the workspace and references are created at the proper places.

2. When running the user command `]RunMake`. 

   This user command runs a BAT script `Make.bat` which starts an instance of Dyalog APL with the appropriate version[^appr]. It then loads the workspace `Make.dws` and runs `⎕LX` which is always `#.Make.Run`.

   This function uses the definitions in `publish.config` for compiling whatever is needed to make the project "consumable". Naturally it will be very different depending on whether it is a single class / single namespace script (like `APLTreeUtils`) or an application like `Fire` or something in between like `Laguntza`.

## Example

This is a `publish.config` file that takes advantage of all features on offer. We will discuss the features in detail later on.

```
<tool name="Foo">    
  <version>1.2.1</version>    
  <date>2019-06-20</date>
  <container>#.APLGUI</container>
  <needs>
    <script>APLTreeUtils</script>
    <script>OS</script>
    <script>FilesAndDirs</script>
    <ws copy="Laguntza" library="APL-cation">Laguntza</ws>
    <script development="true">Tester</script>    
  </needs>
  <autoload>1</autoload>    
  <buildid>13</buildid>
  <lx>#.Foo.Run ⍬</lx>
  <initial>#.MyFunction</initial>
  <admin>1</admin>
</tool>
```

## The contents of `publish.config`


### The `<tool>` tag

This is the outmost tag. Its "name" attribute defines the name of the project.

Note a project "Foo" usually lives in `#.Foo`. This is true for almost all APL Team projects except `APLTreeUtils` (that lives for technical reasons in `#._APLTreeUtils`) but not necessarily for, say, Dyalog projects.

The namespace `#.Foo` usually contains test cases and references to any dependencies and might also contain stuff like helpers.


### The tags `<version>`, `<buildid>`, `<date>`

These tags belong together and define a particular version. While `<version>` and `<date>` are supposed to be set by the developer, `<buildid>` is automatically increased whenever the `]RunMake` user command is run on a project.


### The tag `<container>` 

These days by naming convention the name of the container is identical with the "name" attribute of the `<tool>` tag preceded by an underscore (`_`).

### The tag `<needs>`

This tag might be empty. If it is not empty it will contain either `<script>` or `<ws>` tags or both.

The tag is used to define dependencies for both loading a project as well as "Making" the project.

### The tags `<script>` and `<ws>`

These tags may occur only as children of the `<needs>` tag.

The value is the name of a project the current one depends on.

By default it is assumed that the dependency is a sibling of the current project. Given this depedency for the project "FilesAndDirs":

```
<tag name="FileAndDirs">
...
<needs>
  <script>APLTreeUtils</script>
</needs>
```

This would work because both projects ("FilesAndDirs" and "APLTreeUtils") are part of the APLTree library and therefore siblings.

In order to define a dependency that lives in a different library you need to define the library.

#### The `library` attribute

This value, when specified, is **not** a fully qualified path but simply the name of one of the sub-folders within the folder where all libraries and their projects live.

This is an example: `<script library="APLTree">APLTreeUtils</script>`

#### The `development` attribute

By default a dependency is loaded no matter what. By setting `development="true"` you can make sure that the dependency is loaded when `]OpenMyAcreProject` is executed but ignored when `]RunMake` is executed.

This is an example: `<script development="true">Tester</script>`

Note: `<script development="1">` achieves the same but is now deprecated.

#### The tag `<script>`

This tag is used in case the dependency is simply a single script. It may carry the `library` and the `development` attribute but no other attributes.

#### The tag `<ws>`

This tag is used in case the dependency is something that is available as a workspace. It may carry the `library` and the `development` attributes but also the `copy` attribute. 

`copy` can be used to specify one or several (comma separated) objects to be copied from the given workspace rather than the workspace as a whole.

This is an example: `<ws copy="GUI">APLGUI</ws>`.

##### The tag `<erase>`

It might well be that a copy operation triggered by the `<ws>` tag copied more objects than actually required. In this case the `<erase>` objects with its sub-tag `<obj>` can be used to ridden any unwanted objects.

Example:

```
<needed>
<ws copy="GUI">APLGUI</ws>
</needed>
<erase>
  <obj>#.GUI.Busy</obj>
</erase>
```

### The `<autoload>` tag

This tag is 1 only for any APLTeam projects. It means that the project is loaded in a standard fashion. For other projects, like Carlisle's "Rumba", the `<autoload>` value would be 0.

### The `<buildid>` tag

This tag's value is the building ID of a project. 

It is automatically increased by the `]RunMake` user command. This allows to tell two versions apart despite them having the same version number and version date.

### The `<lx>` tag

This tag can be passed to `Maker.Set_LX`. If it is not empty then this function will set `⎕LX` in the current workspace accordingly.

This is an example: `<lx>#.AutoHotkey.Run</lx>`

### The `<admin>` tag

This tag should carry either 0 or 1 as value. 

If it is a 1 then the user command `]RunMake` makes sure that the instance of Dyalog that will load the workspace `Make.dws` and run its `⎕LX` will be started in elevated mode.

### The `<initial>` tag

If this tag exists at all it must carry the name of a fully qualified function name.

The user command `]OpenMyProject` will execute that function automatically after the acre project was opened.

### The `<scriptonly>` tag

This is either 1 or 0. A 1 means that the project consists of a single script and nothing else.


[^appr]: "Appropriate" is the oldest version of Dyalog APL supported for a given project.