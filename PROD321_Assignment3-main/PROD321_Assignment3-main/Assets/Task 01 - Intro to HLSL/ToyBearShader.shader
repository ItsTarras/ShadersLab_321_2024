/* In Task 1, you will be modifying this vertex/fragment
 * shader to learn about Shader programming, including how
 * to create variables, use Semantic tagging, swizzle packed 
 * array variables, use properties, and set uniform shader
 * variables values from C# code
 *
 * The places you should write the various pieces of code
 * for the subtasks are highlighted with comments.
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

// The name of our shader
Shader "Assignment3/Task1/ToyBearShader"
{
    // A list of properties which will show in the Unity inspector
    // for this shader
    Properties
    {
        // Properties are in the format
        // ShaderVariableName ("InspectorVariableName", InspectorDataType) = DefaultValue
        inflationValue ("Inflation Value", Range(-0.5, 1)) = 0
        /*******
         * TODO: Code for Sub task 4 goes here (3/3)
         *******/
         //Add a properly for the inflation value.
         
    }

    // The code for this shader
    SubShader
    {
        // We will only use one shader pass
        Pass
        {
            // Start of our shader code
            CGPROGRAM

            // This shader has a vertex shader stored in the function vert
            #pragma vertex vert
            // And a fragment shader stored in the function frag
            #pragma fragment frag

            // Include UnityCG.cginc so we can access it's functions and variables
            #include "UnityCG.cginc"


            // This structure will store the raw vertices which go
            // into our vertex shader. 
            struct VertexIn
            {
                // To start with, we just have the vertex's position
                // in object/model space, tagged with the POSITION semantic
                float3 objectSpacePosition : POSITION;

                //Subtask1(1/4)
                 fixed4 colour : COLOR;

                 /*******
                  * Code for Sub Task 3 goes here (1/2)
                  *******/
                  float3 inflation : NORMAL; //normalise inflation!
            };

            // This structure will store the processed vertex data from
            // our vertex shader, which is then passed into our fragment shader
            // In the vertex shader, these will be "per vertex" attributes, in
            // the fragment shader, these will be interpolated "per fragment" attributes
            struct VertexOutFragmentIn
            {
                // The position of the vertex/fragment in homogeneous clip space
                // tagged with the SV_POSITION semantic
                float4 clipSpacePosition : SV_POSITION;

                //subtask1(2/3)
                 fixed4 colour : COLOR;
            };


            // This is where our shader variables go
            // Both Unity and Property variables

            /*******
             * TODO: Code for Sub task 4 goes here (1/3)
             *******/
             float inflationValue;

            // The function which stores our vertex shader
            // It receives a VertexIn struct in variable v
            // and returns a VertexOutFragmentIn struct
            VertexOutFragmentIn vert (VertexIn v)
            {
                // Create our VertexOutFragmentIn return variable o
                VertexOutFragmentIn o;

                // Get the input vertex's object space position 
                float3 objectSpaceVertexPosition = v.objectSpacePosition;

                /*******
                 * Code for Sub Task 3 goes here (2/2)
                 *******/
                 objectSpaceVertexPosition += v.inflation * inflationValue; //Deviant Art bear.

                /*******
                 * TODO:Code for Sub Task 4 goes here (2/3)
                 *******/

                // Convert our object space vertex position to homogeneous clip space
                // using the UnityObjectToClipPos function, and store the value in our
                // output structure's clipSpacePosition member
                o.clipSpacePosition = UnityObjectToClipPos(objectSpaceVertexPosition);

                //Sub1(3/4)
                 o.colour = v.colour;

                // Return the VertexOutFragmentIn variable o
                return o;
            }

            // The function which stores our fragment shader
            // It receives a VertexOutFragmentIn struct in variable i
            // and returns a fixed4 colour semantically tagged with SV_Target
            // This is the colour that will be written into the frame buffer
            fixed4 frag (VertexOutFragmentIn i) : SV_Target
            {
                // Set the colour to white
                fixed4 colour = (1, 1, 1, 1);

                //sub1(4/4)
                colour = i.colour;

                /*******
                 * TODO: Code for sub task 2 goes here
                 *******/
                
                 colour.rb = (1, 2); //Green Bear

                // Return the colour variable
                return colour;
            }

            // The end of our shader code
            ENDCG
        }
    }
}
