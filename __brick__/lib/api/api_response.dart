import './api_error.dart';

/*
Success:
    {
        "code": 200,
        "success": true,
        "message": "New Token Created Successfully",
        "data": {
        "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc4MTA3Nzk0LCJleHAiOjE2NzgxMDgzOTR9.orCg4yh4_Nmt8eQyb-a5Nm34oTLrJ_E36MYP28piGu4"
    }
}*/

/*
Failure:
    {
        "code": 401,
        "success": false,
        "message": "Something went wrong!",
        "data": null
    }
*/

/// Generic API Response Wrapper
class ApiResponse<T> {
  final T? data;
  final ApiError? error;

  ApiResponse({
    this.data,
    this.error,
  });

  bool get isSuccess => error == null;
}
