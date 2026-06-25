import { defineConfig } from "@junobuild/config";

/** @type {import('@junobuild/config').JunoConfig} */
export default defineConfig({
  satellite: {
    // allusion.be runs here as an Astro site on Juno (Internet Computer).
    // `juno deploy` runs the Astro build (predeploy) then uploads dist/.
    ids: {
      development: "<DEV_SATELLITE_ID>",
      production: "u4saf-bqaaa-aaaal-as2aq-cai",
    },
    hosting: {
      source: "dist",
      predeploy: ["npm run build"],
    }
  },
});
