import { Request } from "express";
import multer from "multer";

function imageDestinationDefiner(req: Request): string | undefined {
  const basePath = "uploads/";
  let path;
  switch (req.path) {
    case "/register":
      path = `${basePath}profile-pics/`;
      break;
  }
  return path;
}


//NOTE: So far unused, bcz of the [Render] disk issue! 
const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    let path = "";
    let error: Error | null = null;
    if (imageDestinationDefiner(req)) {
      path = imageDestinationDefiner(req)!;
    } else {
      error = Error("Unknown file was submitted!");
    }
    callback(error, path);
  },
  filename: (req, file, callback) => {
    let error: Error | null = null;
    const name = file.mimetype.split("/");
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    callback(error, `${name[0]}_${uniqueSuffix}.${name[1]}`);
  },
});

const multerConfig = multer({
  // NOTE: Using memory storage. Bcz, [Render] doesn't provide a disk storage, for free instances!
  storage: multer.memoryStorage(),
  preservePath: true,
  fileFilter: (req, file, callback) => {
    let error: Error | null = null;
    // Decision.
    if (!file.mimetype.startsWith("image")) {
      console.log(`Found wrong mimetype : ${file.mimetype}`);
      error = new Error("Invalid file/mime type! (@multerConfig)");
    }
    // Final Output.
    if (error) {
      callback(error);
    } else {
      callback(error, true);
    }
  },
});

export default multerConfig;
