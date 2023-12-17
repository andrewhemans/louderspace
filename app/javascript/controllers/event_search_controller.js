import StimulusReflex from "stimulus_reflex";
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    StimulusReflex.register(this);
  }

  search(event) {
    event.preventDefault();
    this.stimulate("EventSearchReflex#search", event.currentTarget);
  }
}
