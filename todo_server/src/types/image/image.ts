import z from "zod";

export type ImageType = "profile" | "task" | "project";

export default interface Image {
  id?: number;
  uuid: string;
  type: ImageType;
  name: string;
  extension: string;
  imageFile: Buffer;
}
