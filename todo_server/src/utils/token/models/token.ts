import z from "zod";

export const AccessTokenModelSchema = z.object({
    name: z.string(),
    uuid: z.string().uuid(),
    email: z.string().email(),
    expire: z.string().datetime({ offset: true }),
    timestamp: z.string().datetime({ offset: true }),
});

export type AccessTokenModel = z.infer<typeof AccessTokenModelSchema>;