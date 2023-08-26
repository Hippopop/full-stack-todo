import tokenizer from "jsonwebtoken";
import z from "zod";

const accessTokenTime = "2h";
const refreshTokenTime = "2h";

function generateToken(data: string | object): string {
  const tokenSecret = process.env.ACCESSTOKEN as string;
  return tokenizer.sign(data, tokenSecret, {
    expiresIn: accessTokenTime,
  });
}

function generateRefreshToken(data: string | object): string {
  const tokenSecret = process.env.REFRESHTOKEN as string;
  return tokenizer.sign(data, tokenSecret, {
    // expiresIn: refreshTokenTime,
    //** You can set the [expiresIn] only for [Object] types!
  });
}

/* function varifyAccessToken(token: string): boolean {
  var varified = false;
  const tokenSecret = process.env.ACCESSTOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (err) varified = false;
    if (data) varified = true;
  });
  return varified;
} */

function varifyRefreshTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): T | undefined {
  var varified: T | undefined;
  const tokenSecret = process.env.REFRESHTOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (data) {
      const purifiedData = schema.safeParse(data);
      if (purifiedData.success) {
        varified = purifiedData.data;
      }
    }
  });
  return varified;
}

function varifyAccessTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): T | undefined {
  var varified: T | undefined;
  const tokenSecret = process.env.ACCESSTOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (data) {
      const purifiedData = schema.safeParse(data);
      if (purifiedData.success) {
        varified = purifiedData.data;
      }
    }
  });
  return varified;
}

/* function varifyRefreshToken(token: string): boolean {
  var varified = false;
  const tokenSecret = process.env.REFRESHTOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (err) varified = false;
    if (data) varified = true;
  });
  return varified;
} */

export default {
  generateToken,
  generateRefreshToken,
  // varifyAccessToken,
  // varifyRefreshToken,
  varifyAccessTokenWithData,
  varifyRefreshTokenWithData,
};
