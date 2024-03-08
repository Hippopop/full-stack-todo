import z from "zod";

export const AuthTokenSchema = z.object({
  token: z.string(),
  refreshToken: z.string(),
  expiresAt: z.string().datetime({ offset: true }),
});

export type AuthToken = z.infer<typeof AuthTokenSchema>;
