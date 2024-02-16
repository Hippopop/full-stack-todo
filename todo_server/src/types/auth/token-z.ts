import z from "zod";

export const AuthTokenSchema = z.object({
  token: z.string(),
  refreshToken: z.string(),
});

export type AuthToken = z.infer<typeof AuthTokenSchema>;
