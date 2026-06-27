<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login Admin WebGIS</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

  <style>
    body {
      min-height: 100vh;
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      background:
        radial-gradient(circle at top left, rgba(13,110,253,0.14), transparent 30%),
        radial-gradient(circle at bottom right, rgba(249,115,22,0.12), transparent 25%),
        #f4f7fb;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 18px;
    }

    .login-card {
      width: 100%;
      max-width: 420px;
      background: #ffffff;
      border-radius: 18px;
      box-shadow: 0 12px 34px rgba(15, 23, 42, 0.12);
      border: 1px solid rgba(15, 23, 42, 0.08);
      overflow: hidden;
    }

    .login-header {
      background: linear-gradient(135deg, #0d6efd, #0b5ed7);
      color: #ffffff;
      padding: 22px 24px;
    }

    .login-header h1 {
      font-size: 1.12rem;
      font-weight: 700;
      margin: 0 0 6px;
      line-height: 1.3;
    }

    .login-header p {
      margin: 0;
      font-size: 0.82rem;
      opacity: 0.92;
      line-height: 1.35;
    }

    .login-body {
      padding: 22px 24px 24px;
    }

    .form-label {
      font-weight: 700;
      font-size: 0.84rem;
    }

    .form-control {
      border-radius: 11px;
      padding: 10px 12px;
    }

    .btn {
      border-radius: 11px;
      font-weight: 700;
      padding: 10px 12px;
    }

    .small-note {
      font-size: 0.75rem;
      color: #6b7280;
      line-height: 1.35;
      margin-top: 12px;
    }

    .alert {
      font-size: 0.82rem;
      border-radius: 11px;
      display: none;
    }
  </style>
</head>

<body>
  <div class="login-card">
    <div class="login-header">
      <h1><i class="fa-solid fa-user-shield me-2"></i>Login Admin WebGIS</h1>
      <p>Masuk untuk mengelola data fasilitas umum pada WebGIS Kabupaten Sleman.</p>
    </div>

    <div class="login-body">
      <div id="alertBox" class="alert alert-danger mb-3"></div>

      <form id="loginForm">
        <div class="mb-3">
          <label for="username" class="form-label">Username</label>
          <input type="text" class="form-control" id="username" placeholder="Masukkan username admin" required>
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" id="password" placeholder="Masukkan password admin" required>
        </div>

        <button type="submit" class="btn btn-primary w-100" id="loginBtn">
          <i class="fa-solid fa-right-to-bracket me-2"></i>Login
        </button>
      </form>

      <div class="small-note">
        Akun admin: <b>admin</b> / <b>admin123</b><br>
        Data akun admin dibaca dari tabel <b>admin_users</b> pada Supabase.
      </div>

      <div class="mt-3 text-center">
        <a href="index.html" class="small text-decoration-none">
          <i class="fa-solid fa-arrow-left me-1"></i>Kembali ke WebGIS
        </a>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

  <script>
    const SUPABASE_URL = 'https://xwwahjpsuesslsbuvwqu.supabase.co';
    const SUPABASE_ANON_KEY = 'sb_publishable_J12MvST2YuOaoLYDgbuilQ_qLOOBFfA';

    const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

    const loginForm = document.getElementById('loginForm');
    const alertBox = document.getElementById('alertBox');
    const loginBtn = document.getElementById('loginBtn');

    function showAlert(message) {
      alertBox.textContent = message;
      alertBox.style.display = 'block';
    }

    function hideAlert() {
      alertBox.textContent = '';
      alertBox.style.display = 'none';
    }

    loginForm.addEventListener('submit', async function(e) {
      e.preventDefault();
      hideAlert();

      const username = document.getElementById('username').value.trim();
      const password = document.getElementById('password').value.trim();

      if (!username || !password) {
        showAlert('Username dan password wajib diisi.');
        return;
      }

      loginBtn.disabled = true;
      loginBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Memeriksa akun...';

      try {
        const { data, error } = await supabaseClient
          .from('admin_users')
          .select('*')
          .eq('username', username)
          .eq('password', password)
          .maybeSingle();

        if (error) {
          console.error('Supabase error:', error);
          showAlert('Login gagal. Pastikan tabel admin_users bisa dibaca.');
          return;
        }

        if (!data) {
          showAlert('Login gagal. Username atau password salah.');
          return;
        }

        localStorage.setItem('webgis_admin_login', 'true');
        localStorage.setItem('webgis_admin_username', data.username);
        localStorage.setItem('webgis_admin_role', data.role || 'admin');

        window.location.href = 'admin.html';

      } catch (err) {
        console.error('Login error:', err);
        showAlert('Terjadi error saat login: ' + err.message);
      } finally {
        loginBtn.disabled = false;
        loginBtn.innerHTML = '<i class="fa-solid fa-right-to-bracket me-2"></i>Login';
      }
    });
  </script>
</body>
</html>
