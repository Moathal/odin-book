import { TurboMount } from "turbo-mount";
import { registerComponent } from "turbo-mount/react";
import Header from "./packs/Header/Header.jsx"; // import the component you want to register
import Posts from "./packs/Posts/Posts.jsx"; // import the component you want to register
const turboMount = new TurboMount();

// to register a component use:
// registerComponent(turboMount, "Hello", Hello); // where Hello is the imported the component

// to override the default controller use:
registerComponent(turboMount, "Header", Header); // where HelloController is a Stimulus controller extended from TurboMountController
registerComponent(turboMount, "Posts", Posts); // where HelloController is a Stimulus controller extended from TurboMountController
