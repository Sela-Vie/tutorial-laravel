<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersSeeder extends Seeder
{
    public function run(): void
    {
        for ($i = 1; $i <= 10; $i++) {
            $user = sprintf('users%02d', $i);
            User::create([
                'name' => $user,
                'email' => "{$user}@gmail.com",
                'password' => Hash::make('password'),
            ]);
        }
    }
}
