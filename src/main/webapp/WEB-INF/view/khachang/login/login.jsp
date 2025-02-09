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
<header class="p-3 bg-dark text-white mb-5 fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/intro">Jeans Store</a>
        </div>
    </nav>
</header>
<section class="vh-100" style="background-color: #508bfc;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-10 col-md-6 col-lg-5 col-xl-4">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-3 text-center">

            <h3 class="mb-5">Sign in</h3>

            <form action="#" method="">
            <div class="form-floating mb-3">
                <input type="email" id="typeEmailX-2" class="form-control form-control-sm" name="email" required />
                <label class="form-label" for="typeEmailX-2">Email</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" id="typePasswordX-2" class="form-control form-control-sm" name="password"  required />
                <label class="form-label" for="typePasswordX-2">Password</label>
            </div>


                <!-- Checkbox -->
                <div class="form-check d-flex justify-content-start mb-3">
                    <input class="form-check-input" type="checkbox" value="" id="form1Example3" />
                    <label class="form-check-label" for="form1Example3"> Remember password </label>
                </div>

                <button class="btn btn-primary btn-sm btn-block" type="submit">Login</button>

                <hr class="my-4">

                <button class="btn btn-sm btn-block btn-primary" style="background-color: #dd4b39;" type="button">
                    <i class="fab fa-google me-2"></i> Sign up
                </button>
            </form>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>
