// See http://brunch.io for documentation.
exports.config = {
  files: {
    javascripts: { joinTo: "app.js" },
    stylesheets: { joinTo: "app.css" }
  },
  paths: {
    watched: ["src"]
  },
  plugins: {
    elmBrunch: {
      mainModules: ["src/Main.elm"],
      elmMake: "elm make",
      outputFolder: "public",
      outputFile: "elm.js"
      // makeParameters: ["--debug"]
    }
  }
};
