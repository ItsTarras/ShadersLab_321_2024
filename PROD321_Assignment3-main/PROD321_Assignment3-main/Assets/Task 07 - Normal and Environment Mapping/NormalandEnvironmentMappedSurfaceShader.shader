/* In Task 7, you will be adding code this metallic surface
 * shader to support normal mapping and environment mapping
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task7/NormalandEnvironmentMappedSurfaceShader"
{

    // Unity Inspector properties
    Properties
    {
        // The main texture of the surface
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        // The Metallic value of our surface
        _Metallic ("Metallic", Range(0, 1)) = 0

        // The Smoothness value of our surface
        _Smoothness ("Smoothness", Range(0, 1)) = 1

        /*******
         * TODO: Sub Task 1 Add the normal texture of the surface here (1/6)
         *******/

        // The magnitude of the normal mapping of the surface
        _NormalMagnitude ("Normal Magnitude", Range(0, 50)) = 1

        /*******
         * TODO: Sub Task 2 Add a cube map for environment mapping here (1/3)
         *******/
    }

   // Our Shader Program
    SubShader
    {
        CGPROGRAM
        // Define a surface shader in the surf function using
        // the standard lighting model
        #pragma surface surf Standard

        // The input structure to our surface function
        struct Input
        {
            // The UV coordinates for our main texture
            float2 uv_MainTex;

            /*******
             * TODO: Sub Task 1 Add the UV coordinates for our normal texture here (3/6)
             *******/

            // The world reflection vector for environment mapping
            /*******
             * TODO: Sub Task 1 If we are modifying our normals (for normal mapping)
             * we need to add INTERNAL_DATA to our world reflection vector
             * after the ; (4/6)
             *******/
            float3 worldRefl; // - contains world reflection vector
        };

        // The sampler2D for our main texture
        sampler2D _MainTex;

        /*******
         * TODO: Sub Task 1 Add the sampler2D for our normal texture (2/6)
         *******/

        // The float for our normal magnitude multiplier
        float _NormalMagnitude;

        /*******
         * TODO: Sub Task 2 Add the samplerCUBE for our environment map texture (2/3)
         *******/

        // The Metallic value for our surface
        float _Metallic;

        // The Smoothness value for our surface
        float _Smoothness;

        // The definition of our Surface Output Standard structure for reference
        /*
        struct SurfaceOutputStandard
        {
            fixed3 Albedo;      // base (diffuse or specular) color
            fixed3 Normal;      // tangent space normal, if written
            half3 Emission;
            half Metallic;      // 0=non-metal, 1=metal
            half Smoothness;    // 0=rough, 1=smooth
            half Occlusion;     // occlusion (default 1)
            fixed Alpha;        // alpha for transparencies
        };
        */

        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutputStandard called o
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Calculate the albedo (diffuse) colour by getting the
            // colour from the main texture and multiplying it by .5
            // Otherwise it appears too bright with the environment map
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * .5;

            /*******
             * TODO: Sub Task 1 Unpack our normal vector from the normal texture (5/6)
             *******/
            
            /*******
             * TODO: Sub Task 1 Multiply our normal by the normal magnitude vector
             * Just uncomment this value when you have added your normal map (6/6)
             *******/
            // o.Normal *= float3(_NormalMagnitude, _NormalMagnitude, 1);

            /*******
             * TODO: Sub Task 1 Normalize the normal (6/6)
             * Just uncomment this value when you have added your normal map
             *******/
            //o.Normal = normalize(o.Normal);

            // Set the surface's metallic value
            o.Metallic = _Metallic;

            // Set the surface's smoothness value
            o.Smoothness = _Smoothness;

            // Calculate the world reflection vector based on the input
            // data and our updated surface normal
            float3 reflectionVector = WorldReflectionVector (IN, o.Normal);

            // Calculate the emission colour of the surface by getting the
            // colour from the Cube Map texture and multiplying it by .5
            // Otherwise it appears too bright

            /*******
             * TODO: Sub Task 2 Change from using the Unity Skybox to the environment map we have defined
             * You will need to use the texCUBE function instead of UNITY_SAMPLE_TEXCUBE (3/3)
             *******/
            o.Emission = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, reflectionVector).rgb  * .5;

        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
