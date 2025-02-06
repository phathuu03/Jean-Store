<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<section class="vh-100" style="background-color: #508bfc;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-10 col-md-6 col-lg-5 col-xl-4">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-3 text-center">



            <h3 class="text-danger mb-5">Sign in</h3>

            <form action="" method="">
            <div class="form-floating mb-3">
                <input type="email" id="typeEmailX-2" class="form-control form-control-sm" name="email" required />
                <label class="form-label" for="typeEmailX-2">Email</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" id="typePasswordX-2" class="form-control form-control-sm" name="password"  required />
                <label class="form-label" for="typePasswordX-2">Password</label>
            </div>

            <div class="row mb-3">
              <div class="col-6">

                <select class="form-select form-select-sm" id="role" name="role" required>
                    <option value="" selected disabled hidden>-- Role --</option>
                    <option value="admin">Admin</option>
                    <option value="user">User</option>
                </select>
              </div>
            </div>

                <button class="btn btn-primary btn-sm btn-block" type="submit">Login</button>

            </form>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>
