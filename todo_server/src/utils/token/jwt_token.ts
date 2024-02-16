import tokenizer from "jsonwebtoken";
import z from "zod";

const accessTokenTime = "2h";
const refreshTokenTime = "2h";

function generateToken(data: string | object): string {
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  return tokenizer.sign(data, tokenSecret, {
    expiresIn: accessTokenTime,
  });
}

function generateRefreshToken(data: string): string {
  const tokenSecret = process.env.REFRESH_TOKEN as string;
  return tokenizer.sign(data, tokenSecret, {
    // expiresIn: refreshTokenTime,
    //** You can set the [expiresIn] only for [Object] types!
  },);
}

/* function verifyAccessToken(token: string): boolean {
  var verified = false;
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (err) verified = false;
    if (data) verified = true;
  });
  return verified;
} */

function verifyRefreshTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): T | undefined {
  var verified: T | undefined;
  const tokenSecret = process.env.REFRESH_TOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (data) {
      const purifiedData = schema.safeParse(data);
      if (purifiedData.success) {
        verified = purifiedData.data;
      }
    }
  });
  return verified;
}

function verifyAccessTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): T | undefined {
  var verified: T | undefined;
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (data) {
      const purifiedData = schema.safeParse(data);
      if (purifiedData.success) {
        verified = purifiedData.data;
      }
    } else {
      console.log(`Token isn't valid : ${err}`);
    }
  });
  return verified;
}

/* function verifyRefreshToken(token: string): boolean {
  var verified = false;
  const tokenSecret = process.env.REFRESH_TOKEN as string;
  tokenizer.verify(token, tokenSecret, (err, data) => {
    if (err) verified = false;
    if (data) verified = true;
  });
  return verified;
} */

export default {
  generateToken,
  generateRefreshToken,
  verifyAccessTokenWithData,
  verifyRefreshTokenWithData,
};
