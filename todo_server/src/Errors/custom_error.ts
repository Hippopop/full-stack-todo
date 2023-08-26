export abstract class CustomErrorStructure extends Error {
  abstract status: number;
  abstract code?: number | string | Array<string> | Array<number>;
  constructor(message: string) {
    super(message);
    Object.setPrototypeOf(this, CustomErrorStructure.prototype);
  }
  
  abstract serializeErrors(): any;
}
