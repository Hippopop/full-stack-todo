import z from "zod";

export const UserSchema = z.object({
  uid: z.number(),
  photo: z.string().optional().nullable(),
  uuid: z.string().uuid("Invalid UUID!"),
  birthdate: z.string().datetime().optional().nullable(),
  email: z.string().email("Please provide a valid email."),
  name: z.string().min(3, "Username must be at least 3 characters long.").optional().nullable(),
});

export type User = z.infer<typeof UserSchema>;



