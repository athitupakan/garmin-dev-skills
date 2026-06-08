---
source: https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Connect_IQ_Basics/Your_First_App.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Your First Connect IQ App

## Creating Your First Project

First you need to create your new project:

1. Use *Ctrl + Shift + P* (*Command + Shift + P* on the Mac) to summon the command palette
2. Type "New Project" and select *Monkey C: New Project*1
3. When prompted with *Set Project Name* enter a name for your new project
4. Select the project type *Watch Face*
5. Select the *Simple* template upon which the project will be based
6. Select *3.2.0* as the minimum API level
7. Set the parent directory for your new project

Once the project is initialized, the following project elements will be created automatically:

- **bin**: Contains binary and debug output from the app compilation
- **resources**: Inputs to the resource compiler, such as layouts, images, fonts, and strings, and language-specific resources
- **source**: Contains the Monkey C source files, initially broken into 'App' and 'View' files
- **manifest.xml**: Application properties like the app id, the app type, and the targeted devices

### About the Minimum SDK Version Field

The minimum SDK version allows you to configure device compatibility by ensuring that only devices that support, at a minimum, the SDK version you've selected will be enabled for your app. For example, if your app relies heavily on a feature of the **2.1.x** SDK, such as the **Sensor History** feature, you can set your minimum SDK version to **2.1.x** and the list of available devices will be pruned such that you cannot select an incompatible product.

### Editing the Supported Products

After creating the project, you will be presented with the project manifest, which is where metadata about your project like the name id, application id and supported products is maintained. Most of this will be auto-created by the *New Project* command, but you will need to edit the supported products:

1. Use *Ctrl + Shift + P* (*Command + Shift + P* on the Mac) to summon the command palette
2. Type "Edit Products" and select *Monkey C: Edit Products*
3. You will be presented with a list of all products that meet your minimum API level. Select the top checkbox to select all products or select the specific products you want to support.

The manifest will update with all products.

## Running the Program

Before running the program, make sure you have one of your source files (In the `source` folder with the `.mc` extension) open and selected in the editor.

1. Select *Run > Run Without Debugging* (*Command + F5* on Mac, *Ctrl + F5* on other platforms)
2. You will be prompted with the list of products your application supports. Select one from the list.

If all goes well the simulator will start up and the selected watch will appear:

## Importing an Example

To try one of the Connect IQ sample apps load it into Visual Studio Code:

1. Click the *File* menu
2. Select *Open Folder...*
3. Browse in the downloaded SDK `samples` folder and select the root directory of the sample to import
4. Click *Select Folder* to complete the import

## Side Loading an App

The Monkey C extension provides a wizard to help developers side load an application. The wizard will create an executable (PRG) of the selected project. Here's how to use it:

1. Plug your device into your computer
2. Use *Ctrl + Shift + P* (*Command + Shift + P* on the Mac) to summon the command palette
3. In the command palette type "Build for Device" and select *Monkey C: Build for Device*
4. Select the product you wish to build for. If you are unable to choose a device for which to build (the menu appears empty), it means that there are no valid devices configured for your project. See Editing the Supported Products for instructions.
5. Choose a directory for the output and click *Select Folder*
6. In your file manager, go to the directory selected in step 4
7. Copy the generated `PRG` files to your device's `GARMIN/APPS` directory

1 When using the command palette you will be tempted to type *Money C* instead of *Monkey C* which is understandable as *Money C* is Monkey C's nom de plume in the music industry with such hits as *Mo' Monkeys Mo' Problems* and *Baller C Baller Do*
