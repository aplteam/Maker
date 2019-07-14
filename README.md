# Maker

`Maker` is a framework that makes building an application a breeze when certain conditions and assumptions are met:

* It requires an XML file `publish.config` to be around specifying the properties of the project to be build.

   The tags and attributes of `publish.config` are documented in the file `publish-config.md`.
  
* The target is always a folder `Dist\` in the current directory.
* The project is managed by acre.

Note that `Maker` is closely related to the APLTree library and the APL-cation collection.

Note that all projects belonging to [apltree](https://github.com/aplteam/apltree) and [apl-cation](https://github.com/aplteam/apl-cation) fulfil these criteria.


`Maker` offers helpers for many tasks that need to be carried out when running
`]runmake` from within a project.

Several more assumptions must be met:

* We are building on Windows only (sorry).
* The user command [`GetAcreProjectPath`](https://github.com/aplteam/GetAcreProjectPath) must be available. It basically returns the folder
  the Windows Registry key `HKCU\SOFTWARE\APLTree\AcreProjectPath` points to.
* Underneath `]GetAcreProjectPath` there are folders for either specific clients (like "Dyalog") or specific purposes (like "Dyalog-Tools", "UserCommands", "APLTree" or "APL-cation"). Such sub folders are called "libraries".
* All projects live in sub-folders underneath `]GetAcreProjectPath`.
  
  `Maker.U.GetProjectFolder ''` returns that folder for the current project.
* We expect the file `..\publish.config` specific to the current project to be available from
  the folder `Make.dws` lives in.

  That's because the workspace `Make.dws` lives in a folder `Make\` together with the a BAT script that loads the desired version of Dyalog.
  
* Any project (say `Foo`) is hosted in a namespace ("container" in publish.config) `#._Foo`.
* Acre's configuration file must be named `acre.config` (rather than the deprecated name
  `acreconfig.txt`).

The following namespaces contain helper functions:

* `U`     = General utilites
* `xml`   = Utilities helpful with an XML array

## Template functions
Note that `Maker` comes with three template functions: `Run_1`, `Run_2` and `Run_3`. They
are dealing with different but common scenarios; see the comments in those functions to find out more.

These functions are noted in `Public` in order to make them appear in the documentation, although strictly speaking they are not public functions but just templates.

## Development
For technical reasons `Maker`'s own "publish.config" does not specify anything as needed at all.
You have to bring in whatever is needed yourself by calling `Maker.U.LoadAllScriptsNeededByMaker 1`.

The 1 passed as right argument tells the function that the `Tester` class is needed for executing the test cases. When running as part of the user command `]RunMake` this class is not needed, therefore a 0 is passed then.

However, when developing/debugging `Maker` you can instead execute the niladic function
`Maker.TestCases.Prepare` which perform all necessary steps needed for executing any test case,
including a call to `LoadAllScriptsNeededByMaker`.

Kai Jaeger 

| Created:       | 2019-01-09|
| Latest update: | 2019-07-13 |
