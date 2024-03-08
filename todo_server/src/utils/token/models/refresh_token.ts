import z from "zod";

export const RefreshTokenSchema = z.object({
    token: z.string(),
    sha256: z.string(),
    uuid: z.string().uuid(),
    email: z.string().email(),
    expire: z.string().datetime({ offset: true }),
    timestamp: z.string().datetime({ offset: true }),
});

export type RefreshTokenModel = z.infer<typeof RefreshTokenSchema>;