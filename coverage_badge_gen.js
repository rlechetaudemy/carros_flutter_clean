#yarn init
#yarn add lcov2badge

const lcov2badge = require("lcov2badge");
const fs = require("fs");

const logo = "./coverage_badge.svg";
const lcov = "./coverage/new_lcov.info";

lcov2badge.badge(lcov, function (err, svgBadge) {
  if (err) throw err;

  try {
    if (fs.existsSync(logo)) {
      fs.unlinkSync(logo);
      console.log("[INFO] remove old file");
    }
  } catch (err) {
    console.error(err);
  }

  console.log("[INFO] generate coverage image");
  fs.writeFile(logo, svgBadge, (_) =>
    console.log("[INFO] complete")
  );
});