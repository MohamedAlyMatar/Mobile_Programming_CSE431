package com.example.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    Button btn01;
    TextView textView01;
    EditText editText01;

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        editText01 = findViewById(R.id.editText01);
        btn01 = findViewById(R.id.btn01);
        textView01 = findViewById(R.id.textView01);

        //editText01.getResources().getText(R.string.hint1);

        btn01.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String myNum = editText01.getText().toString();
                if (myNum.isEmpty()) {
                    Toast.makeText(getApplicationContext(), "Must enter a value", Toast.LENGTH_LONG).show();
                } else {
                    int myNumInt = Integer.valueOf(myNum) * 100;
                    textView01.setText("Welcome to the matrix ENG #" + String.valueOf(myNumInt));
                }
            }
        });
    }
}