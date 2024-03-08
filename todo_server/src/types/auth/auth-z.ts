import z, { number } from "zod";

export const AuthSchema = z.object({
  key: number(),
  token: z.string().array().default([]),
  uuid: z.string().uuid().min(1, "User Data(*uid) Corrupted!"),
  email: z.string().email("User Data doesn't contain a valid email."),
  phone: z.string().min(10, "Phone must be at least 10 characters long.").nullable(),
  password: z.string().min(6, "Password should be 6 characters long."),
});

export type AuthType = z.infer<typeof AuthSchema>;
