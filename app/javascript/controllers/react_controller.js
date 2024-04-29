import { Controller } from "@hotwired/stimulus";
import React from "react";
import ReactDOM from "react-dom/client";

import modulePaths from "../react/**/index.tsx";
const modules = {};

// Snazzy code written by Marco Roth on discord
const capitalize = (string) => string.charAt(0).toUpperCase() + string.slice(1);
const camelize = (string) =>
	string.replace(/(?:[_-])([a-z0-9])/g, (_, char) => char.toUpperCase());

modulePaths.forEach((file) => {
	const name = file.filename.split("/").reverse()[1];
	const identifier = capitalize(camelize(name));

	if (!modules.hasOwnProperty(identifier)) {
		modules[identifier] = file.module.default;
	}
});

export default class extends Controller {
	static values = {
		component: String,
		props: Object,
	};

	connect() {
		this.renderComponent();
		document.addEventListener("turbo:load", this.renderComponent);
	}

	disconnect() {
		document.removeEventListener("turbo:load", this.renderComponent);
		this.root.unmount();
	}

	renderComponent = () => {
		const module = modules[this.componentValue];
		if (module) {
			this.root = ReactDOM.createRoot(this.element);
			this.root.render(React.createElement(module, this.propsValue));
		} else {
			console.error(`Could not find module ${this.componentValue}`);
		}
	};
}
