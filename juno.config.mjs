import { defineConfig } from "@junobuild/config";

/** @type {import('@junobuild/config').JunoConfig} */
export default defineConfig({
  satellite: {
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
