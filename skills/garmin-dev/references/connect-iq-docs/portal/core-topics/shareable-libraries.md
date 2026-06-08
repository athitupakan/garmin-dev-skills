---
source: https://developer.garmin.com/connect-iq/core-topics/shareable-libraries/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Shareable_Libraries.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Shareable Libraries

Developers can create custom Monkey C libraries, called Monkey Barrels, that contain source code and resource information that are easily shared across Connect IQ Projects.

Monkey Barrels provide an easy way to store and reuse common code and resources that developers find useful. For example, many developers want a quick way to calculate time to sunrise or sunset. With Monkey Barrels, developers can store this code along with other common code and pull it into their various projects when useful. This saves time and effort allowing developers the ability to have maximum creativity.

## Making a Monkey Barrel

From Visual Studio Code, Barrels can be created as a new project type:

1. Use *Ctrl + Shift + P* (*Command + Shift + P* on the Mac) to summon the command palette
2. Type "New Project" and select *Monkey C: New Project*
3. When prompted with *Set Project Name*, enter a name for your new project
4. Select the project type *Monkey Barrel*
5. Select the minimum API level
6. Set the parent directory for your new project

Once the project is created, you can edit your supported products and permissions in the *manifest.xml*. See Editing the Supported Products for more information. A specific check is in place to ensure that developers cannot have a Barrel with the name "Toybox". The Barrel has now been created—now it's time to fill it!

Developers can think of Barrels as custom modules. In fact this is exactly how they should be set up:

```
module FooBarrel {

    (:Bars)           // Notice the annotations above the submodule names
    module Bars {
        // Create a counter var for the "Current Bars"
        var currentBars = 0;

        // Draw a "Bar"
        function drawBar() {
           // . . . draw a super awesome "Bar"
           return Bar;
        }

        // Increment the Bar counter
        function addBar(currentBars) {
           bars = currentBars;
           bars ++;
           return bars;
        }

        // Get the current Bars
        function getCurrentBars() {
            return currentBars;
        }
    }

    (:BarsToo)        // Notice this here too
    module BarsToo {
        function fancyBars() {
            // . . . Do a fancy thing
            return somethingFancy;
        }
    }

    (:Empty)          // An empty annotation
    module Empty {

        // A sub-module without an annotation
        module AlsoEmpty {
        }
    }

    // This module throws an error
    module throwsError {
    }
}
```

Developers can use annotations to denote sub-modules within their Barrels. Sub-modules with annotations (i.e. the `(:Bars)` annotation above) allow developers to import certain sections of code without importing the entire Barrel. If a module directly below the namespace is found at compile time that is not decorated with an annotation, a warning will be generated. A module lacking an annotation that is found within a module decorated with an annotation will also generate a warning (i.e. `AlsoEmpty` module above). See for more information on how to include Barrels and specific annotations.

Annotations must also be configured in the manifest for the Barrel project:

1. Double click the Barrel `manfest.xml`
2. Summon the command palette and run the *Monkey C: Edit Annotations* command
3. Select *Add Annotation*
4. Input your annotation name

The annotations will be available to use in the Barrel project.

Barrels can also include resources. Resources are created and held within a Barrel in the same format as a regular application and are defined in XML format. See the section of the Programmer's Guide for more info on resources.

The compiler will build the resource module as a sub-module of the Barrel's module. For example, in a Barrel called, `IconLibrary` the module will look like this:

```
IconLibrary {                       // Barrel Level
    Rez {                           // Rez Level
        Drawables {                 // Drawables Level
            var myIcon = 123;       // Resource
        }
    }
}
```

Developers can reference resources within a Barrel by using the following syntax:

```
@IconLibrary.Drawables.myIcon
```

This makes it easy for developers to pull those resources into their projects without any changes. All files utilized by a Barrel must live in the Barrel project's root directory, determined by the directory of the manifest.xml file, as importing files external to the project is not supported.

## Barrels and Versions

Each Barrel has a unique version ID number. This follows the same numbering system as The Connect IQ SDK (`Major.Minor.Micro.Quailifier` or `#.#.#.X`). The version qualifier can only be comprised of letters, numbers, and underscores.

## Exporting a Monkey Barrel

Monkey Barrels are packaged by the Monkey C compiler in order to satisfy a basic syntactical check of the source code. **Note:** While Barrels provide the mechanism of code libraries, they contain all of the unmodified source of your Barrel project.

Do the following to export your Monkey Barrel:

1. Make sure the manifest file specifies all products supported by the app
2. Use the *Monkey C: Export Project* command to generate an `.barrel` file.

If there are no errors ,the barrel is ready to use!

## How to Include Barrels

In order to use a Barrel, developers will need to add it to the current project. This can be done through the Visual Studio Code extension or by manually editing a project's Jungle and manifest file.

### Adding Barrels to a Project with Visual Studio Code

Developers can add new Barrels to their project through the command palette:

1. Use the *Monkey C: Configure Monkey Barrel* command
2. Select *Add Monkey Barrel*
3. Select if you want to add it as a precompiled `.barrel` file or as a link to the barrel project
4. Select the precompiled `.barrel` file or the Monkey Barrel project `.jungle` file, depending on the previous selection

The Barrels will be added to the default Barrel Jungle file automatically. The manifest file will also be updated with those Barrel dependencies. If a Barrel supports annotations, these must be manually configured for the individual Barrel, which will import the annotated portion of the Barrel into the project:

```
# All products include the code
# annotated with 'Bars' and 'BarsToo'
# of the 'FooBarrel' barrel
base.FooBarrel.annotations = Bars;BarsToo
```

**Note:** See the Build Configuration section to see how to deal with Barrels in Jungle configuration files directly.

Once this is done, the selected Barrels will be added to your project.

## Using Monkey Barrels

Once they have been added to a project, using Barrels is straight forward and simple. It is not necessary for Developers to import Barrels into source files with the `using` statement, however they will need a using statement if they choose to use aliases for them:

```
// This is a normal Toybox "using" statment
using Toybox.System;

// This sets up an alias for a "submodule" within a barrel
using FooBarrel.Bars as Bars;
```

At this point, the alias has been set up and the Barrel code has been made available in the project.

```
// This is a normal Connect IQ call
System.println("Cool Bars");

// This is a general Barrels call (No using statment needed)
FooBarrel.BarsToo.fancyBars();

// This is a specific Barrels call (Alias)
var globalBars = Bars.getCurrentBars();

// This is a call to use a resource held in a Barrel
var icon = UserInterface.loadResource(IconLibrary.Rez.Drawables.myIcon)
```

## Run No Evil and Monkey Barrels

Barrels can be used in conjunction with the Run No Evil testing framework to test discrete sections of code. For more information on the Run No Evil testing framework developers can reference the Run No Evil documentation.

1. Right click on the Barrel project root folder
2. Select *Run Tests*

The Barrel code with the correct testing annotations (See Run No Evil documentation), will be tested in the Run No Evil testing framework.

## Barrels In The Command Line

Barrels can be compiled and tested via the command line.

- **`barrelbuild`**: Calls the Monkey C Barrel compiler. Much like `monkeyc` the `barrelbuild` call takes code from multiple files to be included in the library (.barrel file). The `-f` argument is required as the manifest file path is specified in one of the Barrel's Jungle files. For more info, run `barrelbuild` without any arguments to see a full list of argument definitions.

```
> barrelbuild -o <output.barrel> -f <barrel.jungle>
```

- **`barreltest`**: Executes Run No Evil tests on the `.barrel` file. Requires the `-d` argument with a valid device id.

```
> barreltest -o <output.barrel> -f <barrel.jungle> -d <device_id>
```

The Connect IQ team has provided a few useful example Barrels for developers to try. To use these Barrels, go to the Garmin Connect IQ GitHub repository. Clone or download the desired Barrels and add them to the project using one of the previously discussed methods.
