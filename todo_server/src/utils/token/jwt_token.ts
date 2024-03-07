import tokenizer from "jsonwebtoken";
import z from "zod";
import { RefreshTokenModel, RefreshTokenSchema } from "./models/refresh_token";
import { DateTime } from "luxon";
import { createHash } from "node:crypto";

const accessTokenTime = "2h";
const refreshTokenTime = "60 days";

function generateToken(data: string | object): [string, string] {
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  const expire = DateTime.now().plus({ hours: 2 }).toISO();
  const token = tokenizer.sign(data, tokenSecret, {
    expiresIn: accessTokenTime,
  });
  return [token, expire];
}

const _generateRefreshTokenSchema = RefreshTokenSchema.omit({ sha256: true, expire: true, timestamp: true });
type _generateRefreshTokenType = z.infer<typeof _generateRefreshTokenSchema>;
function generateRefreshToken(data: _generateRefreshTokenType): [string, String] {
  const tokenSecret = process.env.REFRESH_TOKEN as string;


  const timeStamp = DateTime.now().toISO();
  const expire = DateTime.now().plus({ hours: 2 }).toISO();
  const newHash = createHash("sha256");
  const hashString = newHash.digest("hex");
  const signData = {
    ...data,
    expire: expire,
    sha256: hashString,
    timestamp: timeStamp,
  } as RefreshTokenModel;

  const refreshToken = tokenizer.sign(signData, tokenSecret, {
    expiresIn: refreshTokenTime,
    //** You can set the [expiresIn] only for [Object] types!
  },);

  return [refreshToken, expire];
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

async function verifyRefreshTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): Promise<T | undefined> {
  const tokenSecret = process.env.REFRESH_TOKEN as string;
  return await new Promise<T | undefined>((resolve, reject) => {
    tokenizer.verify(token, tokenSecret, async (err, data) => {
      if (data) {
        const purifiedData = schema.safeParse(data);
        if (purifiedData.success) {
          resolve(purifiedData.data);
        } else {
          reject(purifiedData.error);
        }
      } else reject(err);
    })
  });

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
