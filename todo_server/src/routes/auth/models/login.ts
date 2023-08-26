import z from "zod";

export const LoginSchema = z.object({
  email: z.string().email("Please provide a valid email."),
  password: z.string().min(8, "Password must be at least 8 characters long."),
});

export type Login = z.infer<typeof LoginSchema>;
