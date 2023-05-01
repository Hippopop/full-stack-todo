import { Request, Response, NextFunction } from "express";
import { ZodError } from "zod";
import {
  ResponseWrapperSchema,
  SimpleError,
  WrapperProps,
} from "../types/response-z";

/* 
This is the wrapper function for handling all the requests. It takes the [schema] to assure the structure of 
the returned data, [successMsg], [errorMsg], and the actual [buisnessLogic] as input.  
This function will call the buisness logic and try to get the  data from it. If the data is successfully fetched,
it will parse the data with the [schema]  and return the response. In case of *error*, it will take the error and 
turn it into a readable format and again parse it with the actual [responseSchema] and return the response.chema]. 

The response will be in the form of a [JSON] object with the following format: 
* On success -> 
  {
    status: 200,
    msg: "Success Message",
    data: "Data" // The data returned from the buisness logic with the given structure(*schema).
  } 
* On error -> 
  {
    msg: "Error Message",
    status: 400, // [400] for known logical errors. And [500] for unexpected errors.
    error: [
      {
        code: [string], // A short indicaion for the point of error.
        description: [string], // The description of the error.
      }
    ],
  }
*/

export const wrapperFunction =
  <T>(wrapperProps: WrapperProps<T>) =>
  async (req: Request, res: Response, next: NextFunction) => {
    const { schema, successMsg, errorMsg, buisnessLogic } = wrapperProps;
    try {
      // *** Calls the actual buisness logic!
      const data = await buisnessLogic(req, res);
      // *** Parses the data and gives it the form of an [Response]!
      const safeData = ResponseWrapperSchema(schema).safeParse({
        status: 200,
        msg: successMsg,
        data: data,
      });
      // *** Checks if the end result is a valid [Response], In case of [success] send the response else throw!
      if (safeData.success) {
        res.status(200).json(safeData.data);
      } else {
        throw safeData.error;
      }
    } catch (error) {
      console.log(error);
      // *** Actual [error] handling!
      if (error instanceof ZodError) {
        // *** If the error type is known, then parse it to a [SimpleError]!
        const safeData = ResponseWrapperSchema().safeParse({
          status: 400,
          msg: errorMsg,
          error: ZodErrorParser(error),
        });
        // *** Then send the response with the list of parsed errors!
        if (safeData.success) {
          res.status(400).json(safeData.data);
        } else {
          // TODO: Handle Unexpected Situations.
        }
      } else {
        // *** In case of unknown [Errors], do a vague parsing, with the error code of [500].
        const safeData = ResponseWrapperSchema().safeParse({
          status: 500,
          msg: errorMsg,
          error: <SimpleError[]>[
            {
              code: [500],
              description: `${error}`,
            },
          ],
        });
        // *** Then send the response with the list of parsed errors!
        if (safeData.success) {
          res.status(500).json(safeData.data);
        } else {
          // TODO: Handle Unexpected Situations.
        }
      }
    }
  };

const ZodErrorParser = (error: ZodError): SimpleError[] => {
  if (error.isEmpty) return [];
  return error.issues.map((issue) => {
    return {
      code: issue.path,
      description: issue.message,
    };
  });
};
