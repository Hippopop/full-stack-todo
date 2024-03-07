import z from "zod";

export const RegistrationUserSchema = z.object({
  name: z.string().min(3),
  email: z.string().email("Please provide a valid email."),
  password: z.string().min(8, "Password must be at least 8 characters long."),
  phone: z.string().min(10, "Your provided phone number is too short.").nullable(),
});

export type RegistrationUserModel = z.infer<typeof RegistrationUserSchema>;