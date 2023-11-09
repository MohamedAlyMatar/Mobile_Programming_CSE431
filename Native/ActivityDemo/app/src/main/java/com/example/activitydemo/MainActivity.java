package com.example.activitydemo;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    Button btn03;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d("debug101", "MainActivity_1 onCreate");

        Button btn02 = findViewById(R.id.btn02);
        Intent intent1 = new Intent(MainActivity.this, MainActivity2.class);

        btn02.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                intent1.putExtra("Key00","CSE431");
                startActivity(intent1);
            }
        });

    }

    @Override
    protected void onStart(){
        super.onStart();
        Log.d("debug101", "MainActivity_1 onStart");
    }

    @Override
    protected void onResume(){
        super.onResume();
        Log.d("debug101", "MainActivity_1 onResume");
    }

    @Override
    protected void onPause(){
        super.onPause();
        Log.d("debug101", "MainActivity_1 onPause");
    }

    @Override
    protected void onStop(){
        super.onStop();
        Log.d("debug101", "MainActivity_1 onStop");
    }

    @Override
    protected void onRestart(){
        super.onRestart();
        Log.d("debug101", "MainActivity_1 onRestart");
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        Log.d("debug101", "MainActivity_1 onDestroy");
    }

    @Override
    protected void onRestoreInstanceState(@NonNull Bundle savedInstanceState){
        super.onRestoreInstanceState(savedInstanceState);
        Log.d("debug101", "MainActivity_1 onRestoreInstanceState");
    }

    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState){
        super.onSaveInstanceState(outState);
        Log.d("debug101", "MainActivity_1 onSaveInstanceState");
    }
}