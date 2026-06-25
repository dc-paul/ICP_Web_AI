import { defineConfig } from "@junobuild/config";

/** @type {import('@junobuild/config').JunoConfig} */
export default defineConfig({
  satellite: {
    // NOTE: satellite u4saf-bqaaa-aaaal-as2aq-cai now hosts the live allusion.be
    // site, deployed from the ~/Sites/Allusion_Claude repo (dc-paul/allusion_be).
    // This project (ICP_Web_AI) is the Juno/Astro experiment; give it its own
    // satellite before deploying so it doesn't overwrite allusion.be.
    ids: {
      development: "<DEV_SATELLITE_ID>",
      production: "<PROD_SATELLITE_ID>",
    },
    hosting: {
      source: "dist",
      predeploy: ["npm run build"],
    }
  },
});
