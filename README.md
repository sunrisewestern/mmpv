# An AppleScript App to Handle custom URL Protocol and Manage Multiple Instances of MPV Player

This guide provides instructions on how to create an AppleScript application that handles custom `mmpv://` URLs for opening files in the MPV media player and allows MPV to handle multiple instances. It includes steps to create the script, convert it into an application, modify the application's `Info.plist` to register the custom URL scheme, and set MPV as the default video player for handling multiple instances.

## Requirements

- macOS operating system
- AppleScript Editor (Script Editor on newer macOS versions)
- Access to the terminal for certain operations
- MPV installed on your system

Here's how you can add a usage section to the README to guide users on how to utilize the AppleScript application effectively:
To clarify the usage of the `mmpv://` URL scheme for both local media files and online URLs, you can update the README to include instructions for both scenarios. Here's how you can present this information:


## Usage

The custom `mmpv://` URL scheme can be used to open both local media files and online media URLs in the MPV player. Here's how to format your URLs:

### Opening Local Media Files

To open a local video file, format your URL like this:

```
mmpv://{path-to-media-file}
```

**Example:**

To open a video file located at `/Users/yourusername/Movies/movie.mp4`, you would use:

```
open mmpv:///Users/yourusername/Movies/movie.mp4
```

### Opening Online Media URLs

To open a media file from an online source, format your URL like this:

```
mmpv://{url}
```

**Example:**

To open a video from an online source, such as a direct video URL:

```
open mmpv://https://example.com/path/to/video.mp4
```

### Advanced Usage

You can also pass parameters to control playback options directly through the URL. For example, to set the volume and speed, format the URL like this:

```
mmpv://{path-or-url}@volume=100_speed=1.6
```

This will open the media file with the specified volume and playback speed settings.

### Using URLs in Web Pages

To integrate the `mmpv://` URL scheme in web pages for direct media playback through MPV, use the following HTML snippet:

```html
<a href="mmpv:///path/to/your/video.mp4@volume=100_speed=1.5">Play in MPV</a>
```

Replace `/path/to/your/video.mp4` or the online URL with the actual path to the media file and adjust the parameters as needed.

### Automating with Scripts

You can automate the opening of media files with specific settings using shell scripts or other scripting languages. Here's an example using a bash script:

```bash
#!/bin/bash
open mmpv:///path/to/video.mp4@volume=90_speed=1.2
```

Make sure to replace `/path/to/video.mp4` or the online URL with the path to your video file and modify the parameters to suit your preferences.


## Steps

1. **Create the AppleScript**

   - Open the **Script Editor** application found in `/Applications/Utilities/`.
   - Enter the following script to handle the `mmpv://` URL scheme and allow multiple instances:

     ```applescript
     on open location this_URL
         if this_URL starts with "mmpv://" then
             set file_path to text 8 thru -1 of this_URL
             set corrected_path to POSIX path of file_path
             try
                 do shell script "open -na /Applications/mpv.app --args --no-terminate-when-idle " & quoted form of corrected_path
             on error errMsg
                 display dialog "Error opening file: " & errMsg
             end try
         end if
     end open location
     ```

   - This script listens for URLs starting with `mmpv://`, extracts the file path, and opens it with MPV, allowing for multiple instances by using the `-n` flag with `open` and `--no-terminate-when-idle` with MPV.

2. **Save the Script as an Application**

   - In the Script Editor, go to **File > Export**.
   - Choose the file format as **Application**.
   - Save the file to your desired location, e.g., `mmpv.app`.

3. **Modify the Info.plist of the Application**

   - Right-click on `mmpv.app` in Finder and select **Show Package Contents**.
   - Navigate to `Contents` and open the `Info.plist` file with a text editor or Xcode.
   - Add the following entries to register the `mmpv` URL scheme:

     ```xml
     <key>CFBundleURLTypes</key>
     <array>
         <dict>
             <key>CFBundleURLName</key>
             <string>Custom URL Scheme for MPV</string>
             <key>CFBundleURLSchemes</key>
             <array>
                 <string>mmpv</string>
             </array>
         </dict>
     </array>
     ```

   - Save and close the `Info.plist` file.

4. **Re-register the Application**

   - Open Terminal and run the following command to re-register the application with Launch Services:

     ```bash
     /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f /path/to/mmpv.app
     ```

   - Replace `/path/to/mmpv.app` with the actual path to your application.

5. **Testing the Application**

   - Try opening a URL with your custom scheme to see if it triggers your application correctly:

     ```bash
     open mmpv:///Users/yourusername/path/to/file.mp4
     ```

   - Replace `/Users/yourusername/path/to/file.mp4` with the actual path to a test video file or http(s) url

## Setting MPV as the Default Video Player

- To make MPV the default player for video files, right-click on any video file in Finder, select **Get Info**, expand **Open with**, select MPV from the list, and click **Change All...** to apply MPV as the default player for all files of that type.

## Troubleshooting

- If the URL scheme does not seem to work, ensure that you have correctly modified the `Info.plist` and re-registered the application.
- Check for any syntax errors in the AppleScript or the `Info.plist` modifications.
- Ensure that MPV is correctly installed and located at `/Applications/mpv.app`.

